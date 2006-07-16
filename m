Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWGPRd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWGPRd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 13:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWGPRd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 13:33:28 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:48747 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750893AbWGPRd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 13:33:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=DhcJqWWtdoAacMTz7eVrtm5VcAHT5coNThmRqlW8LPv2vUpgU/M3u/dr1n9G/hRcGBsTU+d7KUglw/ryOIblOWei7l5QupwoqEWNX1IO3a/yhH5jz6q9o9J9+3ELZ1nfA7oRZFO3zhDDWM9DlayLiQ9XgLCswImDNunYTQ54P7k=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: [2.6.18-rc2][e1000][swsusp] - Regression - Suspend to disk and resume breaks e1000
Date: Sun, 16 Jul 2006 13:33:20 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, NetDev <netdev@vger.kernel.org>
References: <200607160509.52930.shawn.starr@rogers.com> <44BA6A4A.5090007@intel.com>
In-Reply-To: <44BA6A4A.5090007@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607161333.20858.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 July 2006 12:33, Auke Kok wrote:
> [adding netdev to the cc]
>
>
> unfortunately I didn't.
>
> e1000 has a special e1000_pci_save_state/e1000_pci_restore_state set of
> routines that save and restore the configuration space. the fact that it
> works for suspend to memory to me suggests that there is nothing wrong with
> that.
>
> I'm surprised that the t42 comes with a PCI/PCI-X e1000, which changes the
> need for this special routine, and the routine does the exact same thing as
> pci_save_state in your case. These special routines are made to handle
> PCI-E cards properly.
>
> Also there are no config_pm changes related to this in 2.6.18-rc2. Most of
> this code has been in the kernel for a few major releases afaik. This code
> worked fine before, so I don't rule out any suspend-related issues. You
> should certainly compare with 2.6.18-rc1 and make sure it was a regression,
> perhaps even bisect the e1000-related changes if you have the time, which
> is about 22 patches or so.
>
> I'll see if I can find out some more once I get back to work.
>
> Auke

The previous kernel I was using was 2.6.17 vanilla, so between this and -git 
snapshots I'll have to see where that changed.

Thanks ,
Shawn.
