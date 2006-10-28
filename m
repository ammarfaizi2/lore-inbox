Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWJ1KY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWJ1KY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 06:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWJ1KY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 06:24:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:12270 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750748AbWJ1KY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 06:24:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X8n8Nirm4u/+HBpywKXHbur/xstnYMrgJJmKkTSWnN3S26FTBwIBFdqYw0WOyNG2TnLEfuWhqw2au6YXcVrtpBWirZQGp8BzJIdmutaID1LgomVpoFYYJK1n9GeKIFjJeJkLqN6DGLDAUkSOUEByaSMPhwbJ9gwrUmdndDtK05g=
Message-ID: <b6a2187b0610280324s66b06067od4691fa9f79420a7@mail.gmail.com>
Date: Sat, 28 Oct 2006 18:24:58 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: linux-2.6.19-rc2 PCI problem
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       "David Miller" <davem@davemloft.net>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Yinghai Lu" <yinghai.lu@amd.com>
In-Reply-To: <20061028032024.GD27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
	 <20061025013022.GG27968@stusta.de>
	 <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com>
	 <20061026152455.GI27968@stusta.de>
	 <b6a2187b0610270649t4cc71781y8e1695f02e1c608e@mail.gmail.com>
	 <20061027203109.GZ27968@stusta.de>
	 <b6a2187b0610271805w154ca251tb7db33ed0926623@mail.gmail.com>
	 <20061028032024.GD27968@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/06, Adrian Bunk <bunk@stusta.de> wrote:
> Greg, is this 2.6.19-rc1 regression anything you've already heard about,
> or should Jeff bisect for the commit that broke it?

> So it's a PCI problem, not a tg3 issue.
> And tg3 is even not the first driver that fails after this...

Adrian, thanks for the lead, so I decided to try different PCI setting.

Setting to "BIOS" make tg3 works again.

Up to 2.6.18, I was using "PCI access mode (Any)" and had no problem,
but from  2.6.19-rc1 onwards, setting to "ANY" doesn't seem to work
anymore.

I've just tested all 2.6.19-rc[123] and all are working with the
"BIOS" setting, but not "ANY".


New setting in .config ...

CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GOANY is not set


Thanks for all your help!

Jeff.
