Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUI2FAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUI2FAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 01:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUI2FAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 01:00:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38109 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268203AbUI2FAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 01:00:15 -0400
Message-ID: <415A4151.7060301@pobox.com>
Date: Wed, 29 Sep 2004 01:00:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rakesh Jagota <j.rakesh@gdatech.co.in>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: opening a file inside the kernel module
References: <4159E85A.6080806@ammasso.com> <006001c4a5df$ad605c40$8200a8c0@RakeshJagota>
In-Reply-To: <006001c4a5df$ad605c40$8200a8c0@RakeshJagota>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rakesh Jagota wrote:
> Hi all,
> I am working in linux, i would like to know abt whether can I open a file
> inside the kernel module without using any application. If so how how the
> files_struct will be maintained. Does a kernel module has this struct?

Don't do this.  It's incompatible with namespaces.

Instead, figure out some way to pass the file contents to the kernel module.

	Jeff


