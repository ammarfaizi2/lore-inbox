Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWEAS1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWEAS1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWEAS1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:27:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12435 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750908AbWEAS1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:27:23 -0400
Date: Mon, 1 May 2006 11:27:11 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: How to replace bus_to_virt()?
Message-Id: <20060501112711.934f7e02.zaitcev@redhat.com>
In-Reply-To: <mailman.1146409020.11659.linux-kernel2news@redhat.com>
References: <mailman.1146409020.11659.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Apr 2006 16:52:37 +0200, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> The current implementation is this: Sbp2 uses bus_to_virt() to map from 
> 1394 bus addresses (which are currently identical to local host bus 
> addresses) to virtual addresses. [...]

Why do you think that virtual addresses must exist? In case of highmem,
most of the system memory is not even mapped anywhere. So, there's no
possible translation. However, the SCSI stack will make requests for I/O
into those unmapped areas, if your host template allows it.

-- Pete
