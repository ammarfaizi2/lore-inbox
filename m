Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270255AbTGMQKt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270258AbTGMQKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:10:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35774
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270255AbTGMQKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:10:14 -0400
Subject: Re: Avoiding "unused variable" warnings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F117EE3.5010200@pobox.com>
References: <200307131932.24015.arvidjaar@mail.ru>
	 <3F117EE3.5010200@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058113342.561.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 17:22:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-13 at 16:46, Jeff Garzik wrote:
> No need for a macro, just do
> 
> 	(void) var_name;
> 
> It doesn't generate any code, and it shuts up the compiler.

It may do. The proper gcc thing is attribute unused. Both are dangerous
as they hide when the variable becomes really unused

