Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWDYUbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWDYUbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWDYUbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:31:33 -0400
Received: from nproxy.gmail.com ([64.233.182.186]:28470 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932290AbWDYUbd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:31:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:references:in-reply-to:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=X2r7Z9Uc7fP8LRHI84lzJTMUJhXswLu3hoFUEuVDXGw46U78Vs0WtjoEbgQ/kJ4VanOEs1Gf5NIRaSMpAG1eplmyu40ROHXSLdPp6QztLSXP6nDzPrNNRPSmKl/OXZ5w3jryzUxYNv1tda2B3ez4B0zpR0t7luEDHh8Tcf77L8g=
From: Barry Kelly <barry.j.kelly@gmail.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
Date: Tue, 25 Apr 2006 21:31:31 +0100
Message-ID: <jo1t421di6ujku21lfl6s5fvdu0ftcui9q@4ax.com>
References: <mj+md-20060424.201044.18351.atrey@ucw.cz> <444D44F2.8090300@wolfmountaingroup.com> <1145915533.1635.60.camel@localhost.localdomain> <20060425001617.0a536488@werewolf.auna.net> <1145952948.596.130.camel@capoeira> <444DE0F0.8060706@argo.co.il> <mj+md-20060425.085030.25134.atrey@ucw.cz> <444DE539.4000804@argo.co.il> <mj+md-20060425.090134.27024.atrey@ucw.cz> <444DE829.2000101@argo.co.il> <1145956952.596.212.camel@capoeira> <20060425222026.2137dac0@werewolf.auna.net>
In-Reply-To: <20060425222026.2137dac0@werewolf.auna.net>
X-Mailer: Forte Agent 3.3/32.846
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006 22:20:26 +0200, "J.A. Magallon" <jamagallon@able.es>
wrote:

> There is no technical argument to reject to write an OS kernel in C++.
> It would not be slower nor more complicated, and it will be probably safer
> because it leaves less things (from thost you always _must_ do) to
> programmers memories.

In a pageable kernel, it would be harder to guarantee that virtual
methods' code is paged in while locks that govern the VM are held.

Of course you could get the same problem with C and pointers to functions,
but at least you could probe them explicitly. With C++, the vtable is one
step removed.

-- Barry
