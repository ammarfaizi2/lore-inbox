Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVCNMB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVCNMB1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 07:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVCNMB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 07:01:27 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:47726 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261386AbVCNMBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 07:01:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=a6kx4KgaIwiIn4vr5NJe0oygQ6Bh9z6Y3l+hrG4c8OCmfQPmSawli6BZ0BmV2h+02mo21WN0HjrOPbRCN31HCD26hmR5TuRmTiUguOP2zCKTl++Aq631i7YW6gdMqP+4b4DVkCVD5f9TANxOAi13NA3jXkgTWvyosUdpcyduLbA=
Message-ID: <a71293c20503140401651ebfe0@mail.gmail.com>
Date: Mon, 14 Mar 2005 07:01:23 -0500
From: Stephen Evanchik <evanchsa@gmail.com>
Reply-To: Stephen Evanchik <evanchsa@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6.11] IBM TrackPoint support
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050314081949.GA2309@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a71293c2050313210230161278@mail.gmail.com>
	 <20050314081949.GA2309@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 09:19:49 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > +/*
> > + * Mode manipulation
> > + */
> > +#define TP_SET_SOFT_TRANS (0x4E) /* Set mode */
> > +#define TP_CANCEL_SOFT_TRANS (0xB9) /* Cancel mode */
> > +#define TP_SET_HARD_TRANS (0x45) /* Mode can only be set */
> 
> What exactly is transparent mode?

Transparency mode, when enabled, turns off the TrackPoint controller's
interpretation of the byte stream going to and coming from the
external PS/2 port if present.

Soft transparency mode can be cancelled, while hard transparency mode
requires a reset of the device and possibly the machine.

Stephen
