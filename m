Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289220AbSANMui>; Mon, 14 Jan 2002 07:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289226AbSANMu3>; Mon, 14 Jan 2002 07:50:29 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:19398 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S289220AbSANMuY>; Mon, 14 Jan 2002 07:50:24 -0500
From: Christoph Rohland <cr@sap.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: tmpfs accounting (was: losetuping files in tmpfs fails?)
In-Reply-To: <3C35F8B2.98763627@sltnet.lk>
 <a181kp$tl4$1@cesium.transmeta.com>
Organisation: SAP LinuxLab
Date: Mon, 14 Jan 2002 13:43:09 +0100
In-Reply-To: <a181kp$tl4$1@cesium.transmeta.com> ("H. Peter Anvin"'s message
 of "5 Jan 2002 15:18:49 -0800")
Message-ID: <m3pu4daysi.fsf_-_@linux.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 5 Jan 2002, H. Peter Anvin wrote:
> P.S. On kernel.org, I was forced to hack tmpfs so that it returns a
> nonzero size for directories; otherwise "make distclean" breaks for
> older Linux kernels, and the incdiff robot that runs on kernel.org
> relies on this operation working correctly.  It would be a good
> thing if tmpfs could account for the amount of memory consumed by
> directories, etc.

I would not like to add the real size without a bigger goal (I would
not see a problem with a fake size).

On the other side I could imagine that we make the directories tmpfs
files which hold the swap vectors of the real tmpfs files of this
directory. With this we would gain swappable meta data for tmpfs and
had a real size for the directories for free.

Greetings
		Christoph


