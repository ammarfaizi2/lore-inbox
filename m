Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWAMETS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWAMETS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 23:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAMETS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 23:19:18 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:8565 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964799AbWAMETR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 23:19:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: fix-processing-of-obsolete-style-setup-options breaks UML arg parsing
Date: Thu, 12 Jan 2006 23:19:14 -0500
User-Agent: KMail/1.8.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060113011532.GA2663@ccure.user-mode-linux.org>
In-Reply-To: <20060113011532.GA2663@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601122319.15287.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 20:15, Jeff Dike wrote:
> UML has a bunch of parameters styled on the hd<n>= and ide<n>=
> parameters which depend on matching a prefix of the command-line
> argument.  This patch explicitly removes this prefix matching.
> 
> I know that this has "obsolete" written all over it, but I don't see
> any more modern replacement which allows prefix matching.
> module_param seems to be the more modern thing, but AFAICS, it is
> matching entire command-line arguments.  Strangely, it will match when
> the command-line argument is a prefix of the in-kernel parameter
> string, which seems exactly backwards.
> 
> The hd<n>= and ide<n>= switches are still present, in ide_setup, using
> the old mechanism, and they now seem to be broken as well.
>

Argh, I completely missed presence of hd<n>= parameters, sorry...

Andrew, please drop it.

-- 
Dmitry
