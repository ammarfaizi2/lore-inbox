Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279355AbRJWKe2>; Tue, 23 Oct 2001 06:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279358AbRJWKeT>; Tue, 23 Oct 2001 06:34:19 -0400
Received: from mail-01.med.umich.edu ([141.214.93.149]:9074 "EHLO
	mail-01.med.umich.edu") by vger.kernel.org with ESMTP
	id <S279355AbRJWKeH> convert rfc822-to-8bit; Tue, 23 Oct 2001 06:34:07 -0400
Message-Id: <sbd50fac.000@mail-01.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0
Date: Tue, 23 Oct 2001 06:35:09 -0400
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <typo@netcabo.pt>, <linux-kernel@vger.kernel.org>
Subject: Re: UDP binding
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is correct behaviour for Samba. It's not a security issue, since Samba isn't listening in any useable sense to interfaces other than those you request. You'll get 'connection refused' if you try to contact another interface.

Nik


>>> Pedro Corte-Real <typo@netcabo.pt> 10/22/01 02:23PM >>>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1

> I am running samba on a machine with 2 outside interfaces. I want samba to
> listen only to one of them so I put these lines on smb.conf:

> bind interfaces only = True
> interfaces = 192.168.1.1 127.0.0.1

> These setings produce this in netstat -a:

> (...)
> udp        0      0 192.168.1.1:138         0.0.0.0:*
> udp        0      0 192.168.1.1:137         0.0.0.0:*
> udp        0      0 0.0.0.0:138             0.0.0.0:*
> udp        0      0 0.0.0.0:137             0.0.0.0:*
> (...)

> I was told this was because nmbd uses broadcast packets to do it's work and
> for it to listen to broadcast packages it must listen to 0.0.0.0. Is this
> true. Can't it bind to 192.168.1.0 instead?

> How does linux's interface binding API work? Is this really necessary?

> Greetings from Portugal,

> Pedro.


