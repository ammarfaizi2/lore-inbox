Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280689AbRKFXd7>; Tue, 6 Nov 2001 18:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280670AbRKFXds>; Tue, 6 Nov 2001 18:33:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60800 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280673AbRKFXdh>;
	Tue, 6 Nov 2001 18:33:37 -0500
Date: Tue, 06 Nov 2001 15:32:31 -0800 (PST)
Message-Id: <20011106.153231.39156880.davem@redhat.com>
To: maxk@qualcomm.com
Cc: pcg@goof.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac5 && vtun not working
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.0.20011031095211.0dbc23f0@mail1>
In-Reply-To: <20011031.003056.63128206.davem@redhat.com>
	<20011031104323.A2263@schmorp.de>
	<5.1.0.14.0.20011031095211.0dbc23f0@mail1>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Maksim Krasnyanskiy <maxk@qualcomm.com>
   Date: Wed, 31 Oct 2001 09:55:47 -0800

   Here is the patch for TUN/TAP to remove that suboptimality :). 
   So we won't call dev_alloc_name if name is not a template.

This won't work.  The whole purpose of calling dev_alloc_name
is to twofold:

1) Make sure the name string is unique

2) Copy that name into dev->name if it is unique

I'm going to change dev_alloc_name() to allow non-'%' names
instead, that is a better fix.

Franks a lot,
David S. Miller
davem@redhat.com
