Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbQKFQ7d>; Mon, 6 Nov 2000 11:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129090AbQKFQ7Y>; Mon, 6 Nov 2000 11:59:24 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:43527 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129043AbQKFQ7L>; Mon, 6 Nov 2000 11:59:11 -0500
Message-Id: <200011061657.eA6Gv0w08964@pincoya.inf.utfsm.cl>
To: "James A. Sutherland" <jas88@cam.ac.uk>
cc: David Woodhouse <dwmw2@infradead.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: Message from "James A. Sutherland" <jas88@cam.ac.uk> 
   of "Mon, 06 Nov 2000 16:42:12 -0000." <00110616471600.01646@dax.joh.cam.ac.uk> 
Date: Mon, 06 Nov 2000 13:57:00 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Chopped down Cc: list]
"James A. Sutherland" <jas88@cam.ac.uk> said:
> On Mon, 06 Nov 2000, David Woodhouse wrote:

[...]

> > It does not know them. Correct. But with persistent module storage, it 
> > _could_ know them.

> No it cannot. The desired levels have not been defined: there are no
> desired levels to determine! Don't tamper with settings you don't need
> to. 

The problem (AFAIU) is that if the levels aren't set on startup, they are
random in some cases. So you'd have to save (at least) the fact that they
have been initalized. Just that would be easy: Set aside a word in the
kernel, which is set to 0 when booting, and which then gets the value 1
when the hardware is initialized. For more fancy stuff, splitting the
module into data/code (as I suggested) should do the trick with minimal
impact on the rest.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
