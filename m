Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVCNNnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVCNNnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 08:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVCNNnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 08:43:03 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:49626 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261494AbVCNNkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 08:40:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dy8lE7rVh7m5pDGWVm0ynoZrDIqyfK30PZ18Yoq1MlC8qsHFVxHaeALlPkwJmr0+8Cz8K7aF4zCTuWqBtwsmYRL35qBD6JjArtDsmR6kmKYLetknIzWlup6jLqwPia7rXfr21qW9Jv72W0sowWuuRK+FAlpLYTOUnc5+w/XDbaQ=
Message-ID: <a71293c205031405403b353f6e@mail.gmail.com>
Date: Mon, 14 Mar 2005 08:40:22 -0500
From: Stephen Evanchik <evanchsa@gmail.com>
Reply-To: Stephen Evanchik <evanchsa@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] IBM TrackPoint support
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <20050314081949.GA2309@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a71293c2050313210230161278@mail.gmail.com>
	 <20050314081949.GA2309@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 13:19:56 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> How much does it interpret the stream in non-transparent mode? Are
> commands also passed through in soft transparent mode?
>
> I'm asking because we might want to implement a passthrough port
> similarly to what the Synaptics driver does and allow extended protocol
> mice to be connected to the external mouse port.

I originally thought that I could implement something similar to the
Synaptics driver. Unfortunately, while in transparent mode bytes are
relayed unmodified with the TrackPoint controller disabled. In other
words, no simultaneous usage.

That doesn't mean extended protocol mice couldn't be supported in
transparent mode however. I didn't find it particularly useful given
the TrackPoint itself would be disabled.
