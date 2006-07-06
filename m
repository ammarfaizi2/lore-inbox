Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWGFRuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWGFRuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWGFRuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:50:16 -0400
Received: from mserv1.uoregon.edu ([128.223.142.40]:9672 "EHLO
	smtp.uoregon.edu") by vger.kernel.org with ESMTP id S1030368AbWGFRuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:50:14 -0400
Message-ID: <44AD4D24.80200@uoregon.edu>
Date: Thu, 06 Jul 2006 10:49:24 -0700
From: Joel Jaeggli <joelja@uoregon.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <20060706044838.30651.qmail@science.horizon.com> <1152207519.13734.8.camel@localhost.localdomain>
In-Reply-To: <1152207519.13734.8.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-07-06 am 00:48 -0400, ysgrifennodd linux@horizon.com:
>> As far as I can tell, the only thing you want is AUTHENTICATION - you
>> want proof that you are getting a "live" scan taken from a user
>> who's present, and not a replay of what was sent last week.
> 
> Read the papers on the subject. If I can get copies of the unencrypted
> data I can use those to make fake fingers. 
> 
> A finger print is personal data, arguably sensitive personal data. That
> means there are lots of duties to store it securely. It is also very
> hard to revoke a fingerprint so theft of data is highly problematic as
> it will allow me to generate fake fingers. Theft of encrypted data might
> allow replay attacks on one PC. Big deal.

A fingerprint is a good identity token, but it's not a secret, nor is it
really feasible to protect it (IE you leave them everywhere).

see:

http://www.schneier.com/crypto-gram-9808.html#biometrics

The transmission channel for the data must be protected in some way to
prevent replay attacks. challange response, radius style shared secret,
one-time-key approach

The data itself needs to be cryptographically secured on the
authenticating side because, otherwise you can game the identity system.

A- Alice subverts the machine containing the identity management system
and uses bobs finger print data to fool the identity management system
next time.

B - Substitution, alice replaces bobs fingerprint in the identity
management system with her own, now alice is bob.

biometric data might be useful as an identy token, but if used as the
sole source of authentication data it is pretty seriously lacking.

> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
-------------------------------------------------
Joel Jaeggli (joelja@uoregon.edu)
GPG Key Fingerprint:
5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2
