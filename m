Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132881AbRDQVpH>; Tue, 17 Apr 2001 17:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132880AbRDQVo6>; Tue, 17 Apr 2001 17:44:58 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:39579 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S132881AbRDQVow> convert rfc822-to-8bit;
	Tue, 17 Apr 2001 17:44:52 -0400
Date: Tue, 17 Apr 2001 23:43:39 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Wolfgang Rohdewald <WRohdewald@dplanet.ch>
cc: linux-kernel@vger.kernel.org, Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: Possible problem with zero-copy TCP and sendfile()
In-Reply-To: <20010417212249.D0552C24B@poboxes.com>
Message-ID: <Pine.LNX.4.21.0104172340140.9211-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Wolfgang Rohdewald wrote:

> On Tuesday 17 April 2001 22:36, Jan Kasprzak wrote:
> > +    if (len == -1 || len > 0 && len < count) {
> 
> are you sure there are no missing () ?
> 
> if ((len == -1) || (len > 0) && (len < count)) {
> 
> assumig that && has precedence over || (I believe so)

I don't this makes it that much cleaner.
If you want to make it clear what this does you should write it more like
this:

if (len == -1 || (len > 0 && len < count))

I don't think it's the == and < , > that confusing but the || and &&

/Martin

