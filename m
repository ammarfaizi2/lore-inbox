Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbTFNIno (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 04:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbTFNIno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 04:43:44 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:15563 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S265653AbTFNInm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 04:43:42 -0400
Subject: Re: 2.5.70 hangs on boot
From: OverrideX <overridex@punkass.com>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20030613214944.GA10406@suse.de>
References: <1055466518.29294.10.camel@nazgul>
	 <20030613214944.GA10406@suse.de>
Content-Type: text/plain
Message-Id: <1055581050.936.0.camel@nazgul>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 14 Jun 2003 04:57:30 -0400
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-13 at 17:49, Dave Jones wrote:
> Ugh, what a mess. Take a look at http://www.codemonkey.org.uk/post-halloween-2.5.txt
> You'll notice that your .config doesn't contain most of those in the
> 'gotchas' section that it suggests you make sure you have.
> 
> The root cause of this is that you have CONFIG_INPUT=m.
> 
> CONFIG_VT only shows up if you have CONFIG_INPUT=y.
> With it set to =m a whole bunch of options never ever show up in the
> configuration.
> 
> This really wants fixing badly. The source of this problem seems to be
> people taking 2.4 configs (where CONFIG_INPUT=m was fine), and it all
> going pear-shaped when people make oldconfig.  I'm aware of the problems
> that oldconfig can't override variables set in .config, so how about 
> just renaming CONFIG_INPUT to something else ?
> 
> 		Dave

Yep, this was the problem thanks for the heads up -Dan

--
OverrideX <overridex@punkass.com>
GPG Key Fingerprint = 4AD5 CE9C D7C8 0069 BDD3 7F72 3AB2 642A 5A5D EB89

Those who make peaceful revolution impossible will make violent
revolution inevitable. -- John F. Kennedy


