Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVBDKlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVBDKlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbVBDKlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:41:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43476 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261892AbVBDKlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:41:11 -0500
Subject: Re: ext3 extended attributes refcounting wrong?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Mikael Pettersson <mikpe@user.it.uu.se>, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <16899.12681.98586.426731@alkaid.it.uu.se>
References: <16898.43219.133783.439910@alkaid.it.uu.se>
	 <1107473817.2058.172.camel@sisko.sctweedie.blueyonder.co.uk>
	 <16899.12681.98586.426731@alkaid.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107513634.2245.46.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 04 Feb 2005 10:40:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-02-04 at 08:25, Mikael Pettersson wrote:

>  > In which kernel(s) exactly?  There was a fix for that applied fairly
>  > recently upstream.
> 
> I've been seeing this over the last couple of months, with
> (at least) 2.4.28 and newer, and 2.6.9 and newer standard kernels.
> But since I dual boot and switch kernels often, I can't point
> at any given kernel or kernel series as being the culprit.

Plain upstream 2.4.28?  If so, that's probably the trouble, as 2.4
doesn't have any xattr support, so if you delete a file on 2.4 it won't
delete the xattr block for it.

> How recent was that fix? Maybe I'm seeing the aftereffects of
> pre-fix corruption?

It went in on the 15th of January this year.

--Stephen

