Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289542AbSAJSpj>; Thu, 10 Jan 2002 13:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289550AbSAJSp3>; Thu, 10 Jan 2002 13:45:29 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:19941 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289542AbSAJSpS>; Thu, 10 Jan 2002 13:45:18 -0500
Date: Thu, 10 Jan 2002 13:37:56 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: f.jimenez@bigfoot.com, linux-kernel@vger.kernel.org
Subject: Re: array size limit in module?
Message-ID: <20020110133756.A8433@redhat.com>
In-Reply-To: <20020110181054Z289122-13997+3040@vger.kernel.org> <3C3DDAFB.E1DC0EFB@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C3DDAFB.E1DC0EFB@didntduck.org>; from bgerst@didntduck.org on Thu, Jan 10, 2002 at 01:18:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 01:18:35PM -0500, Brian Gerst wrote:
> Use vmalloc for allocations that large, unless you must have the memory
> physically contiguous.  128k is the largest amount of memory you can
> allocate with kmalloc.

Even before he uses vmalloc, he should take a programming 101 course that 
explains the importance of error checking.  kmalloc returned NULL, the 
code didn't handle the case.  Switching to vmalloc will only make the code 
usually work, but still susceptible to crashing.

		-ben
