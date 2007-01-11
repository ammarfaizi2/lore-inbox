Return-Path: <linux-kernel-owner+w=401wt.eu-S1030340AbXAKXpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbXAKXpn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbXAKXpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:45:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:10390 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030331AbXAKXpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:45:42 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jB3PafBhZjFpVeuHj3aJEnMFDQ31zIbKd3oZOxDHwFf0Yn7yAub1DuRs5+tEsJMw9REPGpvsDryo6lGIIvRBhuQnGc3/nvzjjFBueAqxxj87ZhhfiVXbsMo+VT6O12+MBlqqoOmWCU7Jomw0Wy5CsRBxETtKXKyMU98qm8CoKmc=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Finding hardlinks
Date: Fri, 12 Jan 2007 00:43:58 +0100
User-Agent: KMail/1.8.2
Cc: Miklos Szeredi <miklos@szeredi.hu>, bhalevy@panasas.com,
       arjan@infradead.org, mikulas@artax.karlin.mff.cuni.cz,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
References: <1166869106.3281.587.camel@laptopd505.fenrus.org> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu> <20070103124211.GF3062@elf.ucw.cz>
In-Reply-To: <20070103124211.GF3062@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701120043.58317.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 January 2007 13:42, Pavel Machek wrote:
> I guess that is the way to go. samefile(path1, path2) is unfortunately
> inherently racy.

Not a problem in practice. You don't expect cp -a
to reliably copy a tree which something else is modifying
at the same time.

Thus we assume that the tree we operate on is not modified.
--
vda
