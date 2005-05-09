Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVEIKB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVEIKB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 06:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVEIKB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 06:01:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57512 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261177AbVEIKBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 06:01:55 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <0IG400GWS1JUNY@mmp2.samsung.com> 
References: <0IG400GWS1JUNY@mmp2.samsung.com> 
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [uClinux-dev] [PATCH 4/4] nommu - backward compatibility patch for mm/nommu.c 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.1
Date: Mon, 09 May 2005 11:01:48 +0100
Message-ID: <5121.1115632908@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hyok S. Choi <hyok.choi@samsung.com> wrote:

> -		    (*parent)->vma->vm_end == end)
> +		    (!len || (*parent)->vma->vm_end == end))

Please make this configurable. It's bypassing an error case check.

David
