Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbWEYWvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbWEYWvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWEYWvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:51:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:51796 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030502AbWEYWvN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:51:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nE07IaMCznsHywMdjljsNrGpad8Ddf+xXAex+mO9cenO6pDAAcsySc7LFDr2z9a/1IxoI7mWR1HqSTlrgcuz7pweSoqKIsHxmEj93CRBXWO/m2eAKmuv0283ktUbMQ1vxcBkWdSs/wRHFAGXAheYNKxwAKQTBWyvKuxk1jUaGGA=
Message-ID: <9a8748490605251551r4fa54084gc585e79f34dc1554@mail.gmail.com>
Date: Fri, 26 May 2006 00:51:12 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: devmazumdar <dev@opensound.com>
Subject: Re: How to check if kernel sources are installed on a system?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e55715+usls@eGroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e55715+usls@eGroups.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/06, devmazumdar <dev@opensound.com> wrote:
> How does one check the existence of the kernel source RPM (or deb) on
> every single distribution?.
>
> We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> SuSE, Mandrake and CentOS - how about other RPM based distros? How
> about debian based distros?. There doesn't seem to be a a single
> conherent naming scheme.
>
There *is* no coherent naming scheme.
Also, RPM's and .deb's are not the only package formats out there. You
are forgetting (just to name a few) :

 - Slackware Linux's package format
 - Stampede Linux's package format
 - Arch Linux's package format

and there are more...

Then there are people building custom distros from scratch. And then
there are people like me who's distro does ship a kernel package &&
kernel-source package but who doesn't use them, but instead build &
run custom kernels from kernel.org source tarballs.

Finding a way to detect if people have kernel sources available that
are configured to match the current running kernel that'll work for
everyone is a lost cause - give it up.
Looking in  /lib/modules/$(uname -r)/build/  and/or
/lib/modules/$(uname -r)/source/ is probably the best you can do (and
doing that makes sense - at least to me)...


> Another thing, can we please start enforcing that people ship kernel
> source with the base installation? If distributors are distributing
> kernels, then it must be an absolute requirement that they ship kernel
> sources in a "configured" state as well.  If you're not going to
> provide a stable kernel API, then atleast please make this a requirement.
>
Ehh, no.
It's not for the kernel developers to mandate what distributions
install. All we can (and should) require is that they obey the GPL and
make source available according to the terms set forth in the license.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
