Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWHFWbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWHFWbl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWHFWbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:31:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:6547 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750748AbWHFWbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:31:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rFJDYEvef5omxp6ESeIBDqFjbnuNuJRBTpgLSe44S8iIQ1mmiArA63TvIeHo3iBVnlxl3+vycPjh8m5wqPNnvjStp3WGJhWAV/5o1SAL/7Vw37MAbOSwCgrKL7f+DvaT/RQFzO/u3Vq0ZrkQ707R7iQn04EC5ITYETVoj1z8k7Y=
Message-ID: <41840b750608061531u71940fdx3fbf71c0dfc68c26@mail.gmail.com>
Date: Mon, 7 Aug 2006 01:31:39 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Cc: "Olaf Hering" <olaf@aepfle.de>, tytso@mit.edu, rlove@rlove.org,
       khali@linux-fr.org, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060806114004.ff472cff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492242899-git-send-email-multinymous@gmail.com>
	 <20060806005613.01c5a56a.akpm@osdl.org>
	 <41840b750608060256g1a7bb9c3s843d3ac08e512d63@mail.gmail.com>
	 <20060806030749.ab49c887.akpm@osdl.org>
	 <41840b750608060344p59293ce0xc75edfbd791b23c@mail.gmail.com>
	 <20060806145551.GC30009@thunk.org> <20060806164013.GA7637@aepfle.de>
	 <20060806114004.ff472cff.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/06, Andrew Morton <akpm@osdl.org> wrote:
> And I'd say this patch series _is_ substantial because it pokes at
> registers which might be described in confidential/NDA'ed documentation, or
> in ways which might be derived from $OTHER_OS.

For what it's worth to you:
I hereby declare that this patch was developed solely based on public
specifications, observation of hardware behavior by trial&eror, and
specifications made available to me in clean-room settings and with no
attached obligations. So this patch is as pure as the mainline hdaps
driver it fixes (and probably purer than many other drivers), and not
a single line of it is a derivative work of $OTHER_OS code.

If it would help inspire trust, you can look at the tp_smapi revision
history on sf.net, where many of those trials and errors are
immortalized.

As for the register poking, I believe all the code in thinkpad_ec.c
logically follows from the publicly available H8S documentation (see
link at the top of the sourcecode), except for one number (base port
"0x1600") which is already given by the mainline hdaps driver.

  Shem
