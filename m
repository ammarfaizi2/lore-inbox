Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVATOyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVATOyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 09:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVATOyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 09:54:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4807 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262156AbVATOyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 09:54:37 -0500
Date: Thu, 20 Jan 2005 09:54:28 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kausty <kkumbhalkar@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: crypto/api.c: crypto_alg_available(): flags param not used.
In-Reply-To: <41ae44840501200448197d18c0@mail.gmail.com>
Message-ID: <Xine.LNX.4.44.0501200952440.952-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005, Kausty wrote:

> hi
> A small observation. In crypto/api.c in linux-2.6.8.1
> 
> The function:
> int crypto_alg_available(const char *name, u32 flags)
> 
> has a flags param which does not seem to be used.
> 
> though it does not matter much but has this been fixed in later releases?
> xfrm functions in ipsec do call this function but always with flags as 0.
> 
> Thanks and regards
> kausty

IIRC, this was to allow future code to specify preferences for the type of
algorithm driver (e.g. hardware), but has not been used.  This is an
example of why it's a bad idea to add infrastructure which isn't being
used at the time.


- James
-- 
James Morris
<jmorris@redhat.com>


