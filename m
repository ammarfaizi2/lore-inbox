Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTEMUvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbTEMUvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:51:33 -0400
Received: from holomorphy.com ([66.224.33.161]:43196 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263584AbTEMUvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:51:32 -0400
Date: Tue, 13 May 2003 14:04:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mika Penttil? <mika.penttila@kolumbus.fi>
Cc: Dave McCracken <dmccr@us.ibm.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <20030513210403.GT8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mika Penttil? <mika.penttila@kolumbus.fi>,
	Dave McCracken <dmccr@us.ibm.com>,
	Linux Memory Management <linux-mm@kvack.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <154080000.1052858685@baldur.austin.ibm.com> <3EC15C6D.1040403@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC15C6D.1040403@kolumbus.fi>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 11:58:21PM +0300, Mika Penttil? wrote:
> Isn't that what inode->i_sem is supposed to protect...?
> --Mika

It's already called under inode->i_sem. The trouble is that it's not
the ->i_sem but the ->page_lock that's taken by those it's racing
against.


-- wli
