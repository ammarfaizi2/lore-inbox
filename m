Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129195AbQKFRFz>; Mon, 6 Nov 2000 12:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbQKFRFe>; Mon, 6 Nov 2000 12:05:34 -0500
Received: from puce.csi.cam.ac.uk ([131.111.8.40]:52622 "EHLO
	puce.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129089AbQKFRF1>; Mon, 6 Nov 2000 12:05:27 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Mon, 6 Nov 2000 17:01:36 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200011061657.eA6Gv0w08964@pincoya.inf.utfsm.cl>
In-Reply-To: <200011061657.eA6Gv0w08964@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Message-Id: <00110617033201.01646@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, Horst von Brand wrote:
> [Chopped down Cc: list]
> "James A. Sutherland" <jas88@cam.ac.uk> said:
> > On Mon, 06 Nov 2000, David Woodhouse wrote:
> 
> [...]
> 
> > > It does not know them. Correct. But with persistent module storage, it 
> > > _could_ know them.
> 
> > No it cannot. The desired levels have not been defined: there are no
> > desired levels to determine! Don't tamper with settings you don't need
> > to. 
> 
> The problem (AFAIU) is that if the levels aren't set on startup, they are
> random in some cases.

So set them on startup. NOT when the driver is first loaded. Put it in
the rc.d scripts.

> So you'd have to save (at least) the fact that they
> have been initalized. 

No, you don't.

> Just that would be easy: Set aside a word in the
> kernel, which is set to 0 when booting, and which then gets the value 1
> when the hardware is initialized.

Why bother? Just set the settings *explicitly* on boot, rather than in the
driver itself.

> For more fancy stuff, splitting the
> module into data/code (as I suggested) should do the trick with minimal
> impact on the rest.

No need. Let userspace save it somewhere, if that's needed.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
