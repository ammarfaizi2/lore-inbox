Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272341AbRH3RID>; Thu, 30 Aug 2001 13:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272342AbRH3RHx>; Thu, 30 Aug 2001 13:07:53 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:37087 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S272341AbRH3RHj>; Thu, 30 Aug 2001 13:07:39 -0400
Importance: Normal
Subject: Re: lcs ethernet driver source
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFD37F6EF4.433973B0-ONC1256AB8.005BE510@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Thu, 30 Aug 2001 18:58:53 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 30/08/2001 18:58:56
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Woodhouse wrote:

>Erm, Linux on S/390 runs as a virtual machine, doesn't it? Does a lack of
>network drivers not render it completely useless?

Well, you're right that without network connection, there's not much
useful you can do.  However, LCS and QETH are not the only options;
you can also use a CTC or IUCV network interface (and those drivers *are*
open source and in the tree); there's also a third-party open source driver
to access CLAW network devices (not in the official tree, but e.g. part of
the SuSE kernel).

Especially in a virtual machine, you can simply define a virtual CTC or
IUCV
connection and access your network via those devices.

If you are running Linux native on the S/390 (not in a virtual machine)
and have *only* physical LCS or QETH devices, you must use the binary-only
modules; but this doesn't appear to be fundamentally different from other
devices where only binary drivers exist ...


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

