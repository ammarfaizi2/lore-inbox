Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281596AbRK0RBN>; Tue, 27 Nov 2001 12:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRK0RBD>; Tue, 27 Nov 2001 12:01:03 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:9478 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281596AbRK0Q7z>; Tue, 27 Nov 2001 11:59:55 -0500
Date: Tue, 27 Nov 2001 17:59:52 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011127175952.F13416@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain> <20011126165920.N730@lynx.no> <9tumf0$dvr$1@cesium.transmeta.com> <9tuo54$e8p$1@cesium.transmeta.com> <3C02E856.A24BACD5@zip.com.au> <3C02E921.3050107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3C02E921.3050107@zytor.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, H. Peter Anvin wrote:

> Waiting for write barriers to clear is key to implementing fsync()
> efficiently and correctly.

Well, all you want is a feature to write a set of blocks and be
acknowledged of completion of the write before you send more data, but
OTOH you would not want to serialize fsync() operations, see my "groups"
that I told previously. That would probably involve tagging data blocks
in the long run. Not sure if the current tag command API of ATA can
already provide that, if so, all is there, and the barrier can be
implemented in the driver rather than the drive firmware.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
