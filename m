Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUFXGne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUFXGne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 02:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFXGne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 02:43:34 -0400
Received: from mproxy.gmail.com ([216.239.56.246]:52713 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S263962AbUFXGnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 02:43:15 -0400
Message-ID: <7c07cd6904062323437ff6ac69@mail.gmail.com>
Date: Thu, 24 Jun 2004 12:13:11 +0530
From: abhijit <slashdev@gmail.com>
To: Lukasz Michal Rak <l.rak@elka.pw.edu.pl>
Subject: Re: do_gettimeofday( ) precision?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.58.0406231747300.2009@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <7c07cd69040623082311234157@mail.gmail.com> <Pine.GSO.4.58.0406231747300.2009@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004 17:54:13 +0200 (CEST), Lukasz Michal Rak
<l.rak@elka.pw.edu.pl> wrote:

> I don't know the way how to do it, but I wonder about 
> precision of such mechanism (if any exists).

basically i want some counter w/ microsend resolution that fits into 32 bits.
couple of possible solutions come to my mind:

[1]  use TSC and convert it to microsec
[2] use get_timeofday( ) and convert to microsec
[3] use xtime variable directly and convert to microsec
(any other ways?)

conversion in [1] will be costly (a div involved). 
conversion in [2]/[3] can be done using bit operators. (usec|sec << 20)
but [2] will incur function call overhead which i'd like to avoid.

so is using xtime directly ok and reliable?

thanks
abhijit
