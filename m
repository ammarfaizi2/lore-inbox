Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSF1KwQ>; Fri, 28 Jun 2002 06:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSF1KwP>; Fri, 28 Jun 2002 06:52:15 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:60170 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317110AbSF1KwP>; Fri, 28 Jun 2002 06:52:15 -0400
Date: Fri, 28 Jun 2002 14:54:06 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1 broke OSF binaries on alpha
Message-ID: <20020628145406.A17560@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Alan,

IIRC, the problem is that BSD and OSF readv/writev(2) manuals
explicitly talked of 32 bit iov_len, thus allowing the application
to pass junk in an upper half of the 64 bit word.
This change broke widely used netscape and acrobat reader,
please revert it until we have a better solution:

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.37)
	[PATCH] PATCH; make readv/writev SuS compliant

Ivan.
