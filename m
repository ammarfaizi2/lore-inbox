Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWA3Hod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWA3Hod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 02:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWA3Hoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 02:44:32 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:49042 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751260AbWA3Hoc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 02:44:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nSPF5cOdXCm6rRiZwoxBe3myo7z16I1eu9lI1ysP5KjLTCWOZbr9f3yWNlh4+5v2VGdyo2Fx/Q6F/zTqxPuHEG+KDWxAOXPmIS5bIWsrajLG+DA7QJ4s/N3UjyMwXl8Yl2WoVtGAXnT14zj3XHa2+3ZEzyfM2lr0lNH7xUy0UN8=
Message-ID: <4807377b0601292344u5defbbcaw102cd16c49a82d67@mail.gmail.com>
Date: Sun, 29 Jan 2006 23:44:31 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, john.ronciak@intel.com, jgarzik@pobox.com,
       linux-netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: patch "e100: Fix TX hang and RMCP Ping issue" (post-2.6.16-rc1) causes suspend-to-ram breakage
In-Reply-To: <20060129232537.GA8343@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060129232537.GA8343@dominikbrodowski.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/06, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> Hi,
>
> git bisect revealed that 24180333206519e6b0c4633eab81e773b4527cac is
> the first bad commit, which is
>
> "e100: Fix TX hang and RMCP Ping issue (due to a microcode loading issue)"

Thanks for the report, I think that we've already fixed this one. 
Interestingly enough, it isn't a problem with the patch but a
longstanding bug in the code that is triggered by the patch.

Please see:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113847804725851&w=2
