Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbTD3Qio (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 12:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTD3Qio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 12:38:44 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:61858 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261383AbTD3Qin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 12:38:43 -0400
Date: Wed, 30 Apr 2003 18:51:03 +0200
From: bert hubert <ahu@ds9a.nl>
To: P?l Halvorsen <paalh@ifi.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile
Message-ID: <20030430165103.GA3060@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	P?l Halvorsen <paalh@ifi.uio.no>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 04:28:32PM +0200, P?l Halvorsen wrote:
> Hi!
> 
> Does sendfile support UDP connections (SOCK_DGRAM)?

Try it. I bet it doesn't do so, and certainly not usably. Blasting UDP
frames is seldomly useful without checks, like NFS performs.

> Does sendfile remove ALL in-memory data copy operations?

Depends. With some network adaptors it might. Definition of 'zero-copy' is
somewhat misty. Some variants of zero-copy would actually be called
'one-copy' or 'minus-one-copy' in other contexts.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
