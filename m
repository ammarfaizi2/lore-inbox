Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281095AbRKGXkm>; Wed, 7 Nov 2001 18:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281094AbRKGXkc>; Wed, 7 Nov 2001 18:40:32 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:57661 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281118AbRKGXkU>; Wed, 7 Nov 2001 18:40:20 -0500
Date: Wed, 7 Nov 2001 18:40:18 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: David Chandler <chandler@grammatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug Report: Dereferencing a bad pointer
Message-ID: <20011107184018.A6483@redhat.com>
In-Reply-To: <3BE9C261.D7422143@grammatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BE9C261.D7422143@grammatech.com>; from chandler@grammatech.com on Wed, Nov 07, 2001 at 06:23:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 06:23:13PM -0500, David Chandler wrote:
> The following one-line C program, when compiled by gcc 2.96 without
> optimization, should produce a SIGSEGV segmentation fault (on a machine
> with 3 or less gigabytes of virtual memory, at least):
> 
>         int main() { int k  = *(int *)0xc0000000; }
> 
> However, it does not do so under 2.4.x -- it does cause a seg fault
> under
> 2.2.x kernels.

Works here running 2.4.13-ac8+bits.  Are you sure you didn't compile with 
optimization enabled?

		-ben
