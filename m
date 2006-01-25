Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWAYFEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWAYFEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 00:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWAYFEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 00:04:13 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:6767 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750795AbWAYFEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 00:04:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
Date: Wed, 25 Jan 2006 00:04:06 -0500
User-Agent: KMail/1.9.1
Cc: Al Viro <viro@ftp.linux.org.uk>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <20060124181945.GA21955@deprecation.cyrius.com> <d120d5000601241508l1a93aae7ubdf8206209be405c@mail.gmail.com> <20060124231409.GA29982@deprecation.cyrius.com>
In-Reply-To: <20060124231409.GA29982@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601250004.06543.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 18:14, Martin Michlmayr wrote:
> * Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-24 18:08]:
> > > More interesting question: is pis^H^H^Hsysfs interaction in there safe for
> > > modular code?
> > 
> > The core should be safe, at least I was trying to make it this way, so
> > if you see something wrong - shout. Locking is another question
> > though...
> 
> So do you want an updated patch using _GPL to export the symbols or to
> change CONFIG_INPUT to boolean?

I guess having input core as a module does not make much sense, so
we should change CONFIG_INPUT to be boolean _and_ clean up the core
code removing module unloading support.

-- 
Dmitry
