Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTEZGWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 02:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTEZGWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 02:22:52 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:10373 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S264311AbTEZGWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 02:22:51 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: Error during compile of 2.5.69-mm8
Date: Mon, 26 May 2003 08:35:53 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200305230538.38946.schlicht@uni-mannheim.de> <200305241637.07395.schlicht@uni-mannheim.de> <20030525.191818.48503212.davem@redhat.com>
In-Reply-To: <20030525.191818.48503212.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305260835.57145.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. Mai 2003 04:18 schrieb David S. Miller:
>    From: Thomas Schlichter <schlicht@uni-mannheim.de>
>    Date: Sat, 24 May 2003 16:36:59 +0200
>
>    I also attached a patch that fixes the SET_MODULE_OWNER thing for
>    net/ipv4/ by using static initializers
>
> I can't apply these patches, there are errors.  You remove
> the esp4_type->owner setting, but don't put the static initializer
> in there.

I created the patches against -mm8 with the SET_MODULE_OWNER lines modified by 
hand to match your patched version, so the patches apply here cleanly...

> I suppose you do test the changes you make in your patches, right?
> What was the test you made to make sure the esp4_type module ownership
> was set correctly? :-)

Well, I looked into the code...
In version 1.26 of the file net/ipv4/esp.c rusty already added the static 
initializer into the struct.

Best regards
   Thomas Schlichter
