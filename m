Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUK1K2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUK1K2f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 05:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUK1K2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 05:28:35 -0500
Received: from quechua.inka.de ([193.197.184.2]:60363 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261426AbUK1K2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 05:28:33 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Organization: Deban GNU/Linux Homesite
In-Reply-To: <E1CYLpf-0001VQ-00@dorka.pomaz.szeredi.hu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 28 Nov 2004 11:28:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E1CYLpf-0001VQ-00@dorka.pomaz.szeredi.hu> you wrote:
>  * @fd     file descriptor
>  * @param  name of the parameter to get/set
>  * @dir    direction flag indicating either get, set, or set-get
>  * @value  value to set parameter to (set) or store current value into (get)
>  * @size   size of value
>  */
> int fparam(int fd, const char *param, int dir, void *value, size_t size);
> 
> I know it's been talked about in the past.  Is anyone interested?

The set-get is supposed to be used for queries, too? The size of value is
only used for the get case to describe the buffer length in that case?
because otherwise the set-get case may require a short value in and a large
answer structure out.

The syscall should also allow cunking in response, unless we remove all
high-volumne answers from it.

Gruss
Bernd
