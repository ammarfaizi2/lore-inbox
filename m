Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVAGJjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVAGJjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 04:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVAGJjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 04:39:37 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:44642 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261329AbVAGJjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 04:39:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=W1P7+k3AJcBz2fR7r5ztgcfeBSt3xxzYwXWmRT7zmQWPNWSLpcn4VokHC8VtAc9+O51PJirjYF9VQdmuagVD4tDigZIhaim4r0jHabaGeJZv+CA9ItvHtyaUyKNoDkdehnYWcmOc+qL//47P1ywYhPbrJfwF5WKeQwREusbMPIU=
Message-ID: <40f323d005010701395a2f8d00@mail.gmail.com>
Date: Fri, 7 Jan 2005 10:39:34 +0100
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>, Mike Werner <werner@sgi.com>
Subject: Re: 2.6.10-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106002240.00ac4611.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005 00:22:40 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/
> 
> - Various minorish updates and fixes
> 
> Changes since 2.6.10-mm1:
> 


When i launch neverball (3d games), X get killed and I have the
following error in dmesg (3d card 9200SE, xserver : Xorg) :

[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held  
                                                                 
[drm:drm_unlock] *ERROR* Process 10657 using kernel context 0

reverting the following patches solve the problem:
agpgart-add-bridge-parameter-to-driver-functions.patch
agpgart-allow-multiple-backends-to-be-initialized.patch
drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch

I tried the fix from Mike Werner, but it doesn't work in my case.

I can provide more information if needed.

regards,

Benoit
