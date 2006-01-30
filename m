Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWA3MXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWA3MXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 07:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWA3MXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 07:23:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38847 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932242AbWA3MXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 07:23:53 -0500
Date: Mon, 30 Jan 2006 12:23:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       acahalan@gmail.com, "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060130122349.GA13871@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jengelh@linux01.gwdg.de, James@superbug.co.uk, mrmacman_g4@mac.com,
	linux-kernel@vger.kernel.org, acahalan@gmail.com,
	"unlisted-recipients:; "@pop3.mail.demon.net
References: <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk> <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr> <43DDFBFF.nail16Z3N3C0M@burner> <20060130120408.GA8436@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130120408.GA8436@merlin.emma.line.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 01:04:08PM +0100, Matthias Andree wrote:
> Why is it a *kernel* task to invent SCSI identifier for a non-SCSI
> transport that does not have such identifiers, in addition to the device
> name? libscg is already doing it for /dev/hd* and /dev/pg*.
> How about USB or Firewire or SATA? Do they have ID or LUN?

Nothing but SPI (parallel scsi) has a target id.  Everything that broadly
falls under SAM has luns.  Because SPI is dying transport the scsi
midlayer will get rid of having a mandatory target id mid-term.  Relying
on the target id to have any useful meaning is dangerous, it doesn't
have a really useful meaning on anything but SPI.

