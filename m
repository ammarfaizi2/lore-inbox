Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268893AbTGTXSl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbTGTXSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:18:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65508
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268893AbTGTXSk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:18:40 -0400
Subject: Re: BUG in pdc202xx_old.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?J=FCrgen?= Stohr <juergen.stohr@gmx.de>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200307202206.21872.juergen.stohr@gmx.de>
References: <200307202206.21872.juergen.stohr@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1058743864.32464.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jul 2003 00:31:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-20 at 21:06, Jürgen Stohr wrote:
>                          * check to make sure drive on same channel
>                          * is u66 capable
>                          */
> -                       if (hwif->drives[!(drive->dn%2)].id) {
> +                       if (hwif->drives[!(drive->dn%2)].present) {

This doesn't really seem to make sense for current IDE - drive[n].id is
never NULL. On old systems it was and this test was needed so we didnt
check ultra dma flags on an ident free drive (old ST506 etc)

That makes me curious as to what is really going on here.

