Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSK1K7T>; Thu, 28 Nov 2002 05:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSK1K7T>; Thu, 28 Nov 2002 05:59:19 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25474 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S265413AbSK1K7L>;
	Thu, 28 Nov 2002 05:59:11 -0500
Date: Thu, 28 Nov 2002 12:06:28 +0100
From: KELEMEN Peter <fuji@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS performance ...
Message-ID: <20021128110627.GD26875@chiara.elte.hu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200211241521.09981.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200211241521.09981.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
Organization: ELTE Eotvos Lorand University of Sciences, Budapest, Hungary
X-GPG-KeyID: 1024D/EE4C26E8 2000-03-20
X-GPG-Fingerprint: D402 4AF3 7488 165B CC34  4147 7F0C D922 EE4C 26E8
X-PGP-KeyID: 1024/45F83E45 1998/04/04
X-PGP-Fingerprint: 26 87 63 4B 07 28 1F AD  6D AA B5 8A D6 03 0F BF
X-Comment: Personal opinion.  Paragraphs might have been reformatted.
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Accept-Language: hu,en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marc-Christian Petersen (m.c.p@wolk-project.de) [20021124 15:23]:

Marc, Andrea,

> I think Andrea and me have something in our kernels that may
> cause it. For me I don't know what that can be. I even have no
> idea what it can be :(

The culprit turned out to be an inherited CONFIG_NFS_DIRECTIO
setting.  Having the client kernel (2.4.20rc2aa1) this option
turned off, performance is stable 4 MB/sec (server hasn't
changed).  This is almost twice as good as with 2.4.19-rmap14b.

I understand the CONFIG_NFS_DIRECTIO warning in Configure.help,
but why does it affect 1) client performance and 2) shouldn't it
only matter for files opened with open(..., O_DIRECT)?

> Peter, have you also tested v3 over tcp?

No, for various administrative reasons.

Peter

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Kelemen Péter     /       \       /       \       /      fuji@elte.hu
.+'         `+...+'         `+...+'         `+...+'         `+...+'
