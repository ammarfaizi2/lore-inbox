Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWECA0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWECA0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWECA0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:26:31 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:52605 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751341AbWECA0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:26:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=hAlNM+LTUEI+ZDDzieMXHDVzsTvJsF4pxvbuzkMpHSClpoPdOaaJVoM11FanzCIZd72WrF1WM5KT+nruPlkPZQA/jgeeqa0+v99H1i8PutkqtzXHYoZGLu8A1gkS5T5OGuBH5kdXRIRcfafCZ8LgjY2tzWNR3iK8bcpJdMAfqEI=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
Date: Wed, 3 May 2006 02:26:27 +0200
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>, Val Henson <val.henson@intel.com>
References: <20060430172953.409399000@zion.home.lan> <1146565266.32045.29.camel@laptopd505.fenrus.org>
In-Reply-To: <1146565266.32045.29.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605030226.28047.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 12:21, Arjan van de Ven wrote:
> > This will be useful since the VMA lookup at fault time can be a
> > bottleneck for some programs (I've received a report about this from
> > Ulrich Drepper and I've been told that also Val Henson from Intel is
> > interested about this).

> I've not seen much of this if any at all, the various caches that are in
> place for these lookups seem to function quite well; what we did see was
> glibc's malloc implementation being mistuned resulting in far too many
> mmaps than needed (which in turn leads to far too much page zeroing
> which is the really expensive part. It's not the vma lookup that is
> expensive, it's the page zeroing)
Even to this email, I hope Ulrich will answer.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
