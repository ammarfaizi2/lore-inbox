Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292682AbSCDSpa>; Mon, 4 Mar 2002 13:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292685AbSCDSpS>; Mon, 4 Mar 2002 13:45:18 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:27316 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S292681AbSCDSpK>; Mon, 4 Mar 2002 13:45:10 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5 videodev redesign -- #3
Date: Mon, 4 Mar 2002 19:45:41 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020302151538.A7839@bytesex.org> <slrna86gll.lh9.kraxel@bytesex.org> <slrna86rcl.mtf.kraxel@bytesex.org>
In-Reply-To: <slrna86rcl.mtf.kraxel@bytesex.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <iss.60a3.3c83c0b3.49eef.3@mailout.lrz-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 4. März 2002 13:50 schrieb Gerd Knorr:
> Gerd Knorr wrote:
> > > > Comments?  Bugs?  I plan to feed this to Linus soon ...
> > >
> > >  Hi,
> > >
> > >  it seems to me that you are not holding the BKL during
> > >  the open method of the individual driver. This will
> > >  cause races with unplugging on some USB cameras.
> >
> >  What race exactly?
>
> Ok, I've found one:  videodev_unregister() must be locked against
> video_open().  New version of the patch below.

OK. It seems that I took the principle of doing little changes only
too far. Thhis patch seems to solve the problem.

	Regards
		Oliver
