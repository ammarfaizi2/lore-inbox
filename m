Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVBMUbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVBMUbc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 15:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVBMUbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 15:31:31 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:42024 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261301AbVBMUba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 15:31:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ghIHjo08bHN5HEsdgOm9X/6YXirybKa1kPqibNtICic/0kqD1VuwIAHeXKjRINZLNKm9I07bL+tHwvYlsOnIpTFUx/B7y7SyvukVF3h2YhSvEk7KO0o0yyTlM0q/pQBVBWfhnGYe6LrCWuV2Na7bLHSCwRxWIL+veQChV9nyIC0=
Message-ID: <a71293c205021312315e9645c5@mail.gmail.com>
Date: Sun, 13 Feb 2005 15:31:29 -0500
From: Stephen Evanchik <evanchsa@gmail.com>
Reply-To: Stephen Evanchik <evanchsa@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050213193149.GA4315@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a71293c20502031443764fb4e5@mail.gmail.com>
	 <200502031934.16642.dtor_core@ameritech.net>
	 <200502032252.45309.dtor_core@ameritech.net>
	 <a71293c2050213111345d072b0@mail.gmail.com>
	 <20050213193149.GA4315@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2005 20:31:49 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
>
> You're right. The IBM trackpoints unfortunately don't have a 'native'
> mode, they always do full processing and send classic PS/2 packets.
> 
> I think we shouldn't need a handler, since we can use the PS/2 protocol
> one. We'll need some options to set the trackpoint tap behavior (as far
> as I know it can only be mapped to a button), and we'll need a safe
> detection, but that's all.

The tap only sends a button one event. As far as the Press to Select
qualities are concerned, the necessary options are exposed by the
driver in the sysfs filesystem now. Understanding their  effects on
how a press, drag, double press is detected is another matter.

I'll send a 2.6.11-rc4 based patch later today for consideration.

Stephen
