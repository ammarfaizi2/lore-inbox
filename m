Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTI2SMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264185AbTI2SIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:08:05 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:46990 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264161AbTI2SGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:06:41 -0400
Date: Mon, 29 Sep 2003 20:06:29 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 3C59x module doesn't work in 2.6.0-test6
Message-ID: <20030929180629.GA23925@louise.pinerecords.com>
References: <200309281502.38370.cijoml@volny.cz> <20030929101453.18c804dd.rddunlap@osdl.org> <200309291930.57987.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309291930.57987.cijoml@volny.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [cijoml@volny.cz]
> 
> Hi,
> 
> I call simply "modprobe 3c59x" as always.
> In all previous kernels before 2.6.0-test6 it worked (2.4,2.2)
> 
> /etc/modprobe.conf
> alias eth0 3c59x
> options 3c59x 3c509x debug=0 options=4,8
> 
> It's generated from /etc/modules.conf in 2.4
> alias eth0 3c59x
> options 3c59x 3c509x debug=0 options=4,8

Just make these
options 3c59x options=4,8

and don't forget to rerun depmod.

AFAIK the 3c59x driver recognizes no such option as '3c509x'.

-- 
Tomas Szepe <szepe@pinerecords.com>
