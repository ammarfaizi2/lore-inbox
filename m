Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUEKHg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUEKHg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 03:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUEKHg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 03:36:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64686 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262190AbUEKHgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 03:36:24 -0400
Message-ID: <40A0826B.2040301@pobox.com>
Date: Tue, 11 May 2004 03:36:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Gary Wong <gtw@cs.bu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Segmentation fault in i810_audio.c:__i810_update_lvi
References: <20040510123607.T9078@cs.bu.edu> <20040511002728.46e05e4c.akpm@osdl.org>
In-Reply-To: <20040511002728.46e05e4c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Gary Wong <gtw@cs.bu.edu> wrote:
> 
>>I believe that one of two fixes should be applied: either the
>> SNDCTL_DSP_SETTRIGGER ioctl handling should not enable the
>> PCM_ENABLE_{IN,OUT}PUT bits unless file->f_mode is compatible,
>> or i810_release() should ignore the PCM_ENABLE_* bits without
>> the corresponding FMODE_*.
> 
> 
> The first option sounds more appropriate but I wonder if it could break
> existing applications?  Probably not, if it oopses.
> 
> Let's try option #1, please.

Let me also re-diff and spam you with _11_ fixes to i810_audio from 
Herbert Xu.

	Jeff




