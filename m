Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287785AbSAFKR4>; Sun, 6 Jan 2002 05:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287790AbSAFKRq>; Sun, 6 Jan 2002 05:17:46 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:16590 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S287785AbSAFKRb>;
	Sun, 6 Jan 2002 05:17:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: vvikram@av.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: [ingo patch] 2.4.17 benchmarks
Date: Sun, 6 Jan 2002 02:17:30 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020105215048.A9335@av.stanford.edu>
In-Reply-To: <20020105215048.A9335@av.stanford.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NAMs-0000kv-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 5, 2002 21:50, vvikram@av.stanford.edu wrote:
> 2) further i seperately ran ./lat_proc fork; ./lat_proc exec; ./lat_proc
> shell many times on the vanilla and patched kernels. their output is also
> attached in one file [lat_proc.txt]. the patched kernel takes
>    MORE time than the vanilla one......

I'd blame this partially on the reverted fork() execution order bit of his 
patch. The child process really should be executed first, and performance is 
much improved in that case (COW and things). I don't think we should worry 
about breaking obviously incorrect (and already fragile) programs for 2.5.x.

-Ryan
