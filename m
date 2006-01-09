Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWAISar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWAISar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWAISar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:30:47 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:14225 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030232AbWAISap convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:30:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BbzvpFMIUfYjEemNVLR9X5Muy3PIOgXmWyqTjqoaew7EDBIgi38svaZA0u8brw4YruPUlqxHF2M6/jMIgGWnrxcTQtyb6Ye2x6tbOyFJfyPPHk4XK9B+Ntq1+sbEnFTKJGSCuk+gf/oxXbUz/v+LPBPs9EHDV1iu+4S2OmPRjl0=
Message-ID: <d120d5000601091030s6081a34ax3932d480487a2fac@mail.gmail.com>
Date: Mon, 9 Jan 2006 13:30:42 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vernon Mauery <vernux@us.ibm.com>
Subject: Re: [PATCH 24/24] ibmasm: convert to dynamic input_dev allocation
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <43C2AA23.4060107@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060107171559.593824000.dtor_core@ameritech.net>
	 <20060107172102.339318000.dtor_core@ameritech.net>
	 <43C2AA23.4060107@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Vernon Mauery <vernux@us.ibm.com> wrote:
> Dmitry Torokhov wrote:
> > +
> > + err_unregister_mouse_dev:
> > +     input_unregister_device(mouse_dev);
>
> If I understand the API correctly now, shouldn't there be a
>        mouse_dev = NULL;
> right here to prevent the following input_free_device?
>

Argh, I was saying it needed there and ended up forgetting it :( Wll
fix that tonight.

--
Dmitry
