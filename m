Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTEaDPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 23:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbTEaDPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 23:15:12 -0400
Received: from holomorphy.com ([66.224.33.161]:5011 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264120AbTEaDPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 23:15:11 -0400
Date: Fri, 30 May 2003 20:28:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix, version 6
Message-ID: <20030531032818.GH8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030530163720.399a8bac.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530163720.399a8bac.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 04:37:20PM -0700, Andrew Morton wrote:
>  o GFP_DMA32 (or something like that).  Lots of ideas.  jejb, zaitcev,
>    willy, arjan, wli.

Specifically, 64-bit systems need to be able to enforce 32-bit
addressing limits for device metadata like network cards' ring buffers
and SCSI command descriptors.

This is very distinct from 32-bit lowmem exhaustion issues; on 32-bit
the command descriptors and ring buffers are O(devices) and hence not
a lowmem pressure issue (well, the O(devices) bit could be but we might
as well say we don't support it and no one has asked for it to be
handled). Actual data having io done to it is unrelated to this.


-- wli
