Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUBNXG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 18:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUBNXG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 18:06:28 -0500
Received: from [212.28.208.94] ([212.28.208.94]:8972 "HELO dewire.com")
	by vger.kernel.org with SMTP id S263596AbUBNXGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 18:06:25 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: JFS default behavior
Date: Sun, 15 Feb 2004 00:06:23 +0100
User-Agent: KMail/1.6.1
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <402E3066.1020802@laPoste.net> <20040214154055.GH8858@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040214154055.GH8858@parcelfarce.linux.theplanet.co.uk>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402150006.23177.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 February 2004 16.40, you wrote:
> The same goes for file names.  Filename is a sequence of bytes, no more and
> no less.  Anything beyond that belongs to applications.

Should be a sequence of characters since humans are supposed to use them and
it should be the same characters wheneve possible regardless of user's locale.

The  "sequence of bytes" idea is a legacy from prehistoric times when byte == character
was true. That is no longer the case and actually hasn't been for quite a while in
some parts of the world. Interchange is important. The application cannot handle
this since it cannot know what characters a byte string represents. Fixing it in the
kernel is the simple solution since it knows the locale. Its also a small change I
believe. Having an iocharset options for all file systems make it backward compatible
and creates a migration path to UTF-8 as system default locale.

-- robin

