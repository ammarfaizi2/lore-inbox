Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVIGGkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVIGGkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 02:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVIGGkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 02:40:07 -0400
Received: from ns.firmix.at ([62.141.48.66]:3552 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750975AbVIGGkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 02:40:05 -0400
Subject: Re: kbuild & C++
From: Bernd Petrovitsch <bernd@firmix.at>
To: Chris Frey <cdfrey@netdirect.ca>
Cc: "Budde, Marco" <budde@telos.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050906210801.GA27897@netdirect.ca>
References: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de>
	 <1126006234.31664.13.camel@tara.firmix.at>
	 <20050906210801.GA27897@netdirect.ca>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 07 Sep 2005 08:39:54 +0200
Message-Id: <1126075194.24425.5.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 17:08 -0400, Chris Frey wrote:
> On Tue, Sep 06, 2005 at 01:30:34PM +0200, Bernd Petrovitsch wrote:
> > Yes, because the official Linux kernel is pure C (using some gcc
> > extensions).
> > There is http://netlab.ru.is/exception/LinuxCXX.shtml but it is
> > a) not integrated (and will probably never) and
> > b) you can't use parts of C++ anyway with it.
> 
> All the language features are supported, according to them.  The standard
> library is not available that I can see, but it's not available in C
> either, in the kernel.

ACK (and the few necessary equal or similar functions of the standard C
lib are implemented directly).
It depends on the to-be-integrated C++ source if it is clean enough from
these features (let alone from Win* specific stuff) so that it makes
sense to really integrate it (so that future versions can replace it
more easily) and just convert it to pure C (which may be less work now
but more of a maintenance headache).
And no, I don't think that building a "windriverwrapper" (a la
ndiswrapper) is a useful thing.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

