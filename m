Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbUCPAUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbUCPASu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:18:50 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:54489 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263126AbUCPAPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:15:49 -0500
Message-ID: <40564723.4010105@us.ibm.com>
Date: Mon, 15 Mar 2004 16:15:31 -0800
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: DRM reorganization
References: <40562AEC.9080509@us.ibm.com> <20040315152621.43a5bcef.akpm@osdl.org>
In-Reply-To: <20040315152621.43a5bcef.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ian Romanick <idr@us.ibm.com> wrote:
> 
>>We're looking at reorganizing the way DRM drivers are maintained. 
>>Currently, the DRM kernel code lives deep in a subdirectory of the DRI 
>>tree (which is a partial copy of the XFree86 tree).  We plan to move it 
>>"up" to its own module at the top level.  That should make it *much* 
>>easier for people that want to do things with the DRM but don't want all 
>>the rest of X (i.e., DRI w/DirectFB, etc.).
>>
>>When we do this move, we're open to the possibility of reorganizing the 
>>file structure.  What can we do to make it easier for kernel release 
>>maintainers to merge changes into their trees?
> 
> - Make sure that the files in the main kernel distribution are up to date.
> 
> - Prepare a shell script which does all the relevant file moves, send to
>   Linus, along with a diff which fixes up Kconfig and Makefiles.
> 
> - Start patching the files in their new locations.

I'm not 100% sure what you mean.  Right now the files in our CVS are 
split between two directories.  There's a "common" directory, which is 
used on both Linux & BSD, and a Linux-specific directory.  Our intention 
is to shift around where some of the files are in our CVS.  I don't 
think we intend to move where things are in the Linux source tree.

That's part of why I'm asking.  From talking to Linus in the past, I 
know that merging in changes is a PITA due to our funky directory 
structure.  I'd like to make that easier. :)


