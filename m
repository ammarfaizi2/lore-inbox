Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266360AbUAHWUj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266361AbUAHWUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:20:38 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:61711 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S266360AbUAHWUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:20:37 -0500
Date: Thu, 8 Jan 2004 17:20:25 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: trond.myklebust@fys.uio.no, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, raven@themaw.net,
       Michael.Waychison@sun.com, thockin@sun.com
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Message-ID: <20040108222024.GG21498@fieldses.org>
References: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no> <3FFDB272.8030808@zytor.com> <33178.141.211.133.197.1073592524.squirrel@webmail.uio.no> <3FFDC7F4.4070800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFDC7F4.4070800@zytor.com>
User-Agent: Mutt/1.5.4i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 01:13:24PM -0800, H. Peter Anvin wrote:
> Also, your global machine credential is to some degree "all the security
> you get."  Any security which isn't enforced by the filesystem driver
> doesn't exist in a Unix environment; in particular there is no security
> against root.

I only have to trust root on the nfs client machines that I actually
use.  (In fact, I only really have to trust those machines with a
short-lived ticket, preventing even those machines from impersonating me
beyond a limited time.)

> Stupid tricks like remapping uid 0 are just that; stupid
> tricks without any real security value.  You know this, of course.
> However, if you think the automounter doesn't have the privilege to
> access the remote server but the user does, then that's false security.

If the server requires kerberos credentials that only a user has, then
the automounter can't do anything until the user coughs up those
credentials.

--Bruce Fields
