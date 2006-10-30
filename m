Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWJ3OWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWJ3OWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWJ3OWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:22:40 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:18568 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751767AbWJ3OWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:22:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=pVM8GBlwCNKhiUTFxmehLjG4/QMLa6msHk3DNm4rpXdzhCTVyEXK6hgiK9Y/KPSy5agmGZZ/FaJeJ13w4/alYP2aNv91z+kdmuPGO2Y4oYaxv4kdhJGrHA9Pu+oeJm9SCkFoi/snSdP/P2+0UzHsl3Z1f2/4wwpWGcsOAUtw33g=
Message-ID: <161717d50610300622h15d5e40w4a30e1a95b3c2564@mail.gmail.com>
Date: Mon, 30 Oct 2006 09:22:37 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Cc: "Dmitry Torokhov" <dtor@insightbb.com>,
       LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <161717d50610300501w240a8ce1h4d58b1f3f2f759bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608232311.07599.dtor@insightbb.com>
	 <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
	 <200610292234.02487.dtor@insightbb.com>
	 <20061030090851.GA2687@suse.cz>
	 <161717d50610300501w240a8ce1h4d58b1f3f2f759bf@mail.gmail.com>
X-Google-Sender-Auth: a7f771506b16e32e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Dave Neuer <mr.fred.smoothie@pobox.com> wrote:
>
> Maybe I'm missing something, (well actually I'm sure I'm missing
> somethng). Looking at the code again, it's unclear to me why there is
> even a call to the ISR in i8042_aux_write, since the latter function
> already calls i8042_read_data.
>

Whoops, sorry. I meant i8042_command, which is called by
i8042_aux_write before the call to i8042_interrupt, already calls
i8042_read_data.

Dave
