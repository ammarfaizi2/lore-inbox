Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280703AbRKFXyI>; Tue, 6 Nov 2001 18:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280704AbRKFXx7>; Tue, 6 Nov 2001 18:53:59 -0500
Received: from smtphost.qualcomm.com ([129.46.64.223]:32932 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S280703AbRKFXxv>; Tue, 6 Nov 2001 18:53:51 -0500
Message-Id: <5.1.0.14.0.20011106155027.01d14ec0@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 06 Nov 2001 15:53:52 -0800
To: "David S. Miller" <davem@redhat.com>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: 2.4.13-ac5 && vtun not working
Cc: pcg@goof.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011106.153231.39156880.davem@redhat.com>
In-Reply-To: <5.1.0.14.0.20011031095211.0dbc23f0@mail1>
 <20011031.003056.63128206.davem@redhat.com>
 <20011031104323.A2263@schmorp.de>
 <5.1.0.14.0.20011031095211.0dbc23f0@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   Here is the patch for TUN/TAP to remove that suboptimality :). 
>   So we won't call dev_alloc_name if name is not a template.
>
>This won't work.  The whole purpose of calling dev_alloc_name is to twofold:
>
>1) Make sure the name string is unique
>
>2) Copy that name into dev->name if it is unique
>
>I'm going to change dev_alloc_name() to allow non-'%' names instead, that is a better fix.
Ok with me. I new that it's a dev.c bug from the beginning ;-)

Max



