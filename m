Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUEAOAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUEAOAq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 10:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUEAOAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 10:00:46 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:38673 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261987AbUEAOAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 10:00:45 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Mikael Pettersson <mikpe@user.it.uu.se>, marcelo.tosatti@cyclades.com
Subject: Re: gcc-3.4.0 patches for 2.4.27?
Date: Sat, 1 May 2004 17:00:34 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <16527.45935.480630.490196@alkaid.it.uu.se>
In-Reply-To: <16527.45935.480630.490196@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405011658.39572.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 April 2004 16:36, Mikael Pettersson wrote:
> Marcelo,
>
> Will you accept patches allowing gcc-3.4.0 to compile
> 2.4.27 or not? I can understand if you want to be
> conservative and not change _anything_ if you don't have to.
>
> gcc-3.4.0 errors out in 2.4.27-pre1 due to (a) inconsistent
> FASTCALL declarations, (b) uninlinable inlines, and (c)
> -funit-at-a-time which seems to leave unresolved calls to
> strcpy() around [gcc optimises sprintf "%s" to strcpy()].

Instead of disabling -funit-at-a-time, maybe hunt down
and replace sprintf("%s")? Or provide non-inlined
instance of strcpy() to link against, that won't waste much space.
--
vda

