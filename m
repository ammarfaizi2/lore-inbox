Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTJMQZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbTJMQZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:25:35 -0400
Received: from smtp1.fre.skanova.net ([195.67.227.94]:58111 "EHLO
	smtp1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261967AbTJMQZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:25:27 -0400
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Date: Mon, 13 Oct 2003 18:29:15 +0200
User-Agent: KMail/1.5.9
References: <Pine.LNX.4.44.0310131653410.20116-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0310131653410.20116-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200310131829.17691.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 October 2003 16.54, Maciej Zenczykowski wrote:
> > find /usr/lib -type f|sed -e 's!.*!cat & >/dev/null || echo &!'|sh
>
> should obviously be:
>   find /usr/lib -type f|sed -e 's!.*!cat "&" >/dev/null || echo &!'|sh
> in order to accept spaces in file names... (they do happen).

find /usr/lib -type f|sed -e 's!.*!cat "&" >/dev/null || echo "&"!'|sh

To accept even stranger characters... Like parantesis '('
Othervice I get:

sh: line 10051: syntax error near unexpected token `('
sh: line 10051: `cat "/usr/lib/qt-3.0.5/templates/
Dialog_with_Buttons_(Bottom).ui" >/dev/null || echo /usr/lib/qt-3.0.5/
templates/Dialog_with_Buttons_(Bottom).ui'

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
