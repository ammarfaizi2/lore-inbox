Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbSJHXvJ>; Tue, 8 Oct 2002 19:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261323AbSJHXvJ>; Tue, 8 Oct 2002 19:51:09 -0400
Received: from CPE-203-51-24-106.nsw.bigpond.net.au ([203.51.24.106]:9743 "HELO
	cuneata.net") by vger.kernel.org with SMTP id <S261320AbSJHXvI>;
	Tue, 8 Oct 2002 19:51:08 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] Input - Make sure input_dev is initialized where needed [23/23]
Date: Wed, 9 Oct 2002 09:48:58 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <20021008155045.L18546@ucw.cz> <20021008160100.S18546@ucw <20021008160319.V18546@ucw.cz>
In-Reply-To: <20021008160319.V18546@ucw.cz>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210090947.48469.bhards@bigpond.net.au>
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 9 Oct 2002 00:03, Vojtech Pavlik wrote:
> You can import this changeset into BK by piping this whole message to:
> '| bk receive [path to repository]' or apply the patch as usual.
> 'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.
>
> ===================================================================
>
> ChangeSet@1.573.1.58, 2002-10-08 12:51:35+02:00, vojtech@suse.cz
>   Initialize struct input_dev in input drivers before it's passed to
> input_event(). input_register_device() usually does that, but some drivers
> will call input_event() before registering to pre-load the absolute values
> in struct input_dev in an easy way.
Is this the change we discussed? Every input driver should now
init_input_dev(), irrespective of whether it does input_event() before
registering?

Brad

- --
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9o27qW6pHgIdAuOMRAkbUAJ0QRHYO+wEERp1wGVdZOE/0QAzLYQCfVYzF
Kirm1iSdUtdempJu1Kh+fVw=
=cmnq
-----END PGP SIGNATURE-----

