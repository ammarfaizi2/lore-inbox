Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266320AbUAHWZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUAHWZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:25:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65032 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S266320AbUAHWZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:25:23 -0500
Message-ID: <3FFDD8A4.80105@zytor.com>
Date: Thu, 08 Jan 2004 14:24:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: trond.myklebust@fys.uio.no, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, raven@themaw.net,
       Michael.Waychison@sun.com, thockin@sun.com
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no> <3FFDB272.8030808@zytor.com> <33178.141.211.133.197.1073592524.squirrel@webmail.uio.no> <3FFDC7F4.4070800@zytor.com> <20040108222024.GG21498@fieldses.org>
In-Reply-To: <20040108222024.GG21498@fieldses.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:
>
> On Thu, Jan 08, 2004 at 01:13:24PM -0800, H. Peter Anvin wrote:
> 
>>Also, your global machine credential is to some degree "all the security
>>you get."  Any security which isn't enforced by the filesystem driver
>>doesn't exist in a Unix environment; in particular there is no security
>>against root.
> 
> I only have to trust root on the nfs client machines that I actually
> use.  (In fact, I only really have to trust those machines with a
> short-lived ticket, preventing even those machines from impersonating me
> beyond a limited time.)
> 

And when that ticket expires, you better have NFS itself know how to
renew its credentials, or you're up the creek.  Nothing that autofs can
help you with.

> 
>>Stupid tricks like remapping uid 0 are just that; stupid
>>tricks without any real security value.  You know this, of course.
>>However, if you think the automounter doesn't have the privilege to
>>access the remote server but the user does, then that's false security.
> 
> If the server requires kerberos credentials that only a user has, then
> the automounter can't do anything until the user coughs up those
> credentials.
> 

True, but giving them to a privileged daemon is no different that giving
them to the kernel in that way.

	-hpa

