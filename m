Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbUJZJGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUJZJGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbUJZJGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:06:33 -0400
Received: from hell.org.pl ([62.233.239.4]:2825 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261852AbUJZJGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:06:31 -0400
Date: Tue, 26 Oct 2004 11:06:29 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@suse.de>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space for suspend/resume
Message-ID: <20041026090629.GA17454@hell.org.pl>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Len Brown <len.brown@intel.com>, Andi Kleen <ak@suse.de>,
	"Li, Shaohua" <shaohua.li@intel.com>,
	ACPI-DEV <acpi-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>, greg@kroah.com,
	Pavel Machek <pavel@suse.cz>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com> <20041026051100.GA5844@wotan.suse.de> <417DEA8D.4080307@intel.com> <1098780150.2789.19.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1098780150.2789.19.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Arjan van de Ven:
> > What this comes down to is that extended config space is device-specific.
> > Generic solutions will fail.  Only device drivers will work.
> > 
> > If there are no drivers for PCI bridges to properly save/restore
> > their config space, then should create them, even if this is all the 
> > drivers do.
> note that by default, if there is no driver, the first 64 bytes of
> config space are saved/restored.

That's not enough -- some devices with no drivers (think LPC bridges) might
need more (see http://bugme.osdl.org/show_bug.cgi?id=3609).
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
